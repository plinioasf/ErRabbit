package org.mintcode.errabbit.core.analysis.result;

import org.mintcode.errabbit.core.analysis.FieldConverter;
import org.mintcode.errabbit.core.analysis.request.LogAnalysisRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;
import java.util.Map;

/**
 * Graphical analytic result set
 * Created by soleaf on 15. 8. 1..
 */
public class GraphicLogAnalysisResult implements AnalysisResult {

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    GraphicLogAnalysisResultItem root = new GraphicLogAnalysisResultItem("root");

    public GraphicLogAnalysisResult(LogAnalysisRequest req, List<Map<String, Object>> list){
        for (Map<String,Object> row : list){
            GraphicLogAnalysisResultItem superItem = null;
            for (String group : req.group){
                String field = "" + row.get(FieldConverter.converToFieldName(group));
                logger.trace("group" + group + " key + "  + FieldConverter.converToFieldName(group) +  " row " + row.keySet());
                GraphicLogAnalysisResultItem target = findItem(superItem, field);
                superItem = target;
            }
            superItem.addCount((Integer) row.get("count"));
        }
        root.calcPercents();
        logger.debug(root.toString());
    }

    protected GraphicLogAnalysisResultItem findItem(GraphicLogAnalysisResultItem superItem, String field){

        GraphicLogAnalysisResultItem parents;
        if (superItem == null){
            parents = root;
        }
        else{
            parents = superItem;
        }
        if (!parents.subItems.isEmpty()){
            for (GraphicLogAnalysisResultItem item : parents.getSubItems()){
                if (item.getField().equals(field)){
                    return item;
                }
            }
        }

        GraphicLogAnalysisResultItem item = new GraphicLogAnalysisResultItem(field);
        parents.addSub(item);
        return item;
    }

    @Override
    public Object getResult() {
        return root;
    }
}